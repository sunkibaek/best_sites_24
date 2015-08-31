require 'rails_helper'

describe SitesController, type: :controller do
  describe 'MSG_CREATE' do
    it 'returns a string' do
      constant = SitesController::MSG_CREATE

      expect(constant).to be_a String
    end
  end

  describe '#index' do
    context 'with a specific tag' do
      it 'shows sites only with a certain tag' do
        chosen_site = create :site, tags: 'certain_tag'
        not_chosen_site = create :site, tags: 'general_tag'

        get :index, tag: 'certain_tag'

        expect(assigns(:sites)).to eq [chosen_site]
        expect(response).to be_success
      end
    end

    context 'without any tag' do
      it 'shows all sites, first 12, id descending order' do
        20.times do
          create :site
        end

        site_created_last = create :site

        get :index

        expect(assigns(:sites).length).to eq 12
        expect(assigns(:sites).first).to eq site_created_last
        expect(response).to be_success
      end
    end
  end

  describe '#show' do
    context 'with a url slug' do
      it 'renders page of site with requested slug' do
        site_with_requested_slug = create :site, url_slug: 'requested_slug'
        create :site, url_slug: 'un_requested_slug'

        get :show, id: 'requested_slug'

        expect(assigns(:site)).to eq site_with_requested_slug
        expect(response).to be_success
      end
    end

    context 'with a site id' do
      it 'renders page of site with requested id' do
        requested_site = create :site

        get :show, id: requested_site.id

        expect(assigns(:site)).to eq requested_site
        expect(response).to be_success
      end
    end
  end

  describe '#new' do
    subject { get :new }

    context 'with user logged in' do
      it 'renders the page' do
        user = create :user
        sign_in user

        subject

        expect(assigns(:site).new_record?).to be true
        expect(response).to be_success
      end
    end

    context 'without user logged in' do
      it 'denies the access' do
        expect(subject).to redirect_to new_session_url
      end
    end
  end

  describe '#create' do
    context 'with user logged in' do
      before do
        user = create :user
        sign_in user
      end

      context 'with valid params' do
        subject do
          post :create, site: {
            url: 'http://www.example.com',
            tags: 'tag_a, tag_b',
            screenshot_file_name: "#{Rails.root}/spec/support/assets/" \
              "edition_cnn_com.png",
            screenshot_content_type: 'image/png',
            screenshot_file_size: 4477981,
            screenshot_updated_at: Time.zone.now }
        end

        it 'renders show page with notice' do
          stub_request(:get, "http://www.example.com/").
            to_return(:status => 200, :body => example_response)

          subject

          expect(subject).to redirect_to site_url(Site.last.id)
          expect(flash[:notice]).to eq SitesController::MSG_CREATE
        end

      end

      context 'with invalid params' do
        subject { post :create, site: { url: '', tags: '', screenshot: '' } }

        it 'renders new page' do
          expect(subject).to render_template :new
        end
      end
    end

    context 'without user logged in' do
      subject { post :create, site: { site: {} } }

      it 'denies the access' do
        expect(subject).to redirect_to new_session_url
      end
    end
  end

  def example_response
    <<-response.strip_heredoc
      <html>
        <head>
          <title>Example Title</title>
        </head>
        <body>
          This is example body.
        </body>
      </html>
    response
  end
end
