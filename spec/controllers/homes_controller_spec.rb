require 'rails_helper'

describe HomesController, type: :controller do
  describe '#show' do
    context 'with a specific tag' do
      it 'shows sites only with a certain tag' do
        chosen_site = create :site, tags: 'certain_tag'
        not_chosen_site = create :site, tags: 'general_tag'

        get :show, tag: 'certain_tag'

        expect(assigns(:recent_sites)).to eq [chosen_site]
        expect(response).to be_success
      end
    end

    context 'without any tag' do
      it 'shows all sites, first 12, id descending order' do
        20.times do
          create :site
        end

        site_created_last = create :site

        get :show

        expect(assigns(:recent_sites).length).to eq 12
        expect(assigns(:recent_sites).first).to eq site_created_last
        expect(response).to be_success
      end
    end
  end
end
