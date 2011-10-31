module NothingHelper
  def placeholder(w, h)
    # image_tag "http://placehold.it/#{w}x#{h}"
    image_tag "http://placekitten.com/g/#{w}/#{h}", :alt => "placeholder"
  end
end
