module ChallengesHelper
  def embed(youtube_url)
    youtube_id = youtube_url.split('v=').last
    content_tag(:iframe, nil, src: "//www.youtube.com/embed/#{youtube_id}", frameborder: 0)
  end
end
