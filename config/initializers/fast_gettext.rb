require "i18n/backend/fallbacks" 
FastGettext.add_text_domain 'app', :path => File.join(Rails.root, 'locale'), :type => :po
FastGettext.default_text_domain = 'app'

I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)

RoutingFilter::Locale.include_default_locale = Configuration::include_default_locale_in_urls

#This monkey patch fixes the locale issue where the gem gettext_i18n_rails dasherizes every locale.
module I18n
  class Config
    def locale
      FastGettext.locale
    end
  end
end
