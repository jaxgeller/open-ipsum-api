require 'rails_helper'

RSpec.describe IpsumsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Ipsum. As you add validations to Ipsum, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # IpsumsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all ipsums as @ipsums" do
      ipsum = Ipsum.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:ipsums)).to eq([ipsum])
    end
  end

  describe "GET #show" do
    it "assigns the requested ipsum as @ipsum" do
      ipsum = Ipsum.create! valid_attributes
      get :show, {:id => ipsum.to_param}, valid_session
      expect(assigns(:ipsum)).to eq(ipsum)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Ipsum" do
        expect {
          post :create, {:ipsum => valid_attributes}, valid_session
        }.to change(Ipsum, :count).by(1)
      end

      it "assigns a newly created ipsum as @ipsum" do
        post :create, {:ipsum => valid_attributes}, valid_session
        expect(assigns(:ipsum)).to be_a(Ipsum)
        expect(assigns(:ipsum)).to be_persisted
      end

      it "redirects to the created ipsum" do
        post :create, {:ipsum => valid_attributes}, valid_session
        expect(response).to redirect_to(Ipsum.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved ipsum as @ipsum" do
        post :create, {:ipsum => invalid_attributes}, valid_session
        expect(assigns(:ipsum)).to be_a_new(Ipsum)
      end

      it "re-renders the 'new' template" do
        post :create, {:ipsum => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested ipsum" do
        ipsum = Ipsum.create! valid_attributes
        put :update, {:id => ipsum.to_param, :ipsum => new_attributes}, valid_session
        ipsum.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested ipsum as @ipsum" do
        ipsum = Ipsum.create! valid_attributes
        put :update, {:id => ipsum.to_param, :ipsum => valid_attributes}, valid_session
        expect(assigns(:ipsum)).to eq(ipsum)
      end

      it "redirects to the ipsum" do
        ipsum = Ipsum.create! valid_attributes
        put :update, {:id => ipsum.to_param, :ipsum => valid_attributes}, valid_session
        expect(response).to redirect_to(ipsum)
      end
    end

    context "with invalid params" do
      it "assigns the ipsum as @ipsum" do
        ipsum = Ipsum.create! valid_attributes
        put :update, {:id => ipsum.to_param, :ipsum => invalid_attributes}, valid_session
        expect(assigns(:ipsum)).to eq(ipsum)
      end

      it "re-renders the 'edit' template" do
        ipsum = Ipsum.create! valid_attributes
        put :update, {:id => ipsum.to_param, :ipsum => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested ipsum" do
      ipsum = Ipsum.create! valid_attributes
      expect {
        delete :destroy, {:id => ipsum.to_param}, valid_session
      }.to change(Ipsum, :count).by(-1)
    end

    it "redirects to the ipsums list" do
      ipsum = Ipsum.create! valid_attributes
      delete :destroy, {:id => ipsum.to_param}, valid_session
      expect(response).to redirect_to(ipsums_url)
    end
  end

end
