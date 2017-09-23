require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe "GET #index" do
    let(:article) { create :article }

    before { article }

    it "returns a success response" do
      get :index, params: { article_id: article.id }
      expect(response).to have_http_status(:ok)
    end

    it 'should return only articles comments in the response' do
      article_comment = create :comment, article: article
      create :comment
      get :index, params: { article_id: article.id }
      expect(json['data'].length).to eq(1)
      expect(json['data'][0]['id']).to eq(article_comment.id.to_s)
    end

    it 'should return proper attributes in the response' do
      article_comment = create :comment, article: article
      get :index, params: { article_id: article.id }
      comment_data = json['data'][0]
      expect(comment_data['attributes']).to eq({ 'content' => article_comment.content })
    end

    it 'should have article and user in the relationships' do
      article_comment = create :comment, article: article
      get :index, params: { article_id: article.id }
      comment_relationships = json['data'][0]['relationships']
      expect(comment_relationships['article']['data']['id']).to eq(article.id.to_s)
      expect(comment_relationships['user']['data']['id']).to eq(article_comment.user_id.to_s)
    end

    it 'should have user in the included section' do
      article_comment = create :comment, article: article
      get :index, params: { article_id: article.id }
      expect(json['included'].length).to eq(1)
      comment_included = json['included'][0]
      expect(comment_included['type']).to eq('users')
      expect(comment_included['id']).to eq(article_comment.user_id.to_s)
    end
  end

  describe "POST #create" do
    let(:valid_attributes) {
      skip("Add a hash of attributes valid for your model")
    }

    let(:invalid_attributes) {
      skip("Add a hash of attributes invalid for your model")
    }

    context "with valid params" do
      it "creates a new Comment" do
        expect {
          post :create, params: {comment: valid_attributes}, session: valid_session
        }.to change(Comment, :count).by(1)
      end

      it "renders a JSON response with the new comment" do

        post :create, params: {comment: valid_attributes}, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(comment_url(Comment.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new comment" do

        post :create, params: {comment: invalid_attributes}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end
end
