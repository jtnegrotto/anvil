class PagesController < ApplicationController
  def home
    render inertia: "Home", props: { message: "Hello, world!" }
  end
end
