require "spec_helper"

describe "Routes" do

  describe "Root" do
    it {expect(get: root_path).to route_to("hotels#index")}
  end

  describe HotelsController do

    it {expect(get("/hotels")).to route_to("hotels#index")}

    it {get("/hotels/new").should route_to("hotels#new")}

    it {get("/hotels/1").should route_to("hotels#show", id: "1")}

    it {post("/hotels").should route_to("hotels#create")}

  end

  describe CommentsController do

    it {expect(post("hotels/1/comments")).to be_routable}

    it {expect(post("hotels/1/comments")).to route_to("comments#create", hotel_id: "1")}

  end

  describe RatesController do

    it {expect(post("hotels/1/rates")).to be_routable}

    it {expect(post("hotels/1/rates")).to route_to("rates#create", hotel_id: "1")}

  end

  describe "Devise" do
    it {expect(get: new_user_session_path).to be_routable}

    it {expect(get: new_user_registration_path).to be_routable}

    it {expect(get: edit_user_registration_path).to be_routable}
  end

end