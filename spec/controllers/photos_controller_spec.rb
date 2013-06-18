require 'spec_helper'

describe PhotosController do

  describe 'GET#index' do
    it 'assigns the photos variable' do
      photo = Photo.create(_id: '92', instagram_id: '92', url: 'http://example.com', username: 'honeybooboo', text:'whattttt',location: [1234, 4321])
      get :index
      expect(assigns(@photos)).to eq [photo]
    end

    it 'assigns the geojson variable' do
     Photo.create(_id: '92', instagram_id: '92', url: 'http://example.com', username: 'honeybooboo', text:'whattttt',location: [1234, 4321])
      get :index
      expect(assigns(@geojson)).to eq Photo.to_geojson
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET#show' do
    it 'assigns the photo variable' do
      photo = Photo.create(_id: '92', instagram_id: '92', url: 'http://example.com', username: 'honeybooboo', text:'whattttt',location: [1234, 4321])
      get :show, id: photo._id
      expect(assigns(@photo)).to eq photo
    end

    it 'renders the show template' do
      photo = Photo.create(_id: '92', instagram_id: '92', url: 'http://example.com', username: 'honeybooboo', text:'whattttt',location: [1234, 4321])
      get :show, id: photo._id
      expect(response).to render_template(:show)
    end
  end
end
