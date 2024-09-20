Rails.application.config.content_security_policy do |policy|
  policy.default_src :self, :https, :unsafe_inline
  policy.font_src :self, :https, :data
  policy.img_src :self, :https, :data, "*.terrassa.cat", "terrassa.cat", "*.hereapi.com"
  policy.object_src :none
  policy.script_src :self, :https, :unsafe_inline, :unsafe_eval, "terrassa.cat"
  policy.style_src :self, :https, :unsafe_inline
  policy.frame_src :self, :https, "youtube.com", "*.youtube.com", "*.vimeo.com", "www.youtube-nocookie.com"
  policy.connect_src :self, :https, "terrassa.cat", "*.hereapi.com", "*.jsdelivr.net", "*.amazonaws.com"
end
