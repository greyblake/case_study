shared_examples_for "authorized controller" do |send_request|
  context "not authorized user" do
    before do
      session[:user_id] = nil
    end

    it "redirects" do
      self.instance_eval(&send_request)
      expect(response).to redirect_to root_path
    end
  end
end
