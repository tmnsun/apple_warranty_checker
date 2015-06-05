class App < Sinatra::Application
  get '/' do
    fetch_imei_info(params[:imei]) if !params[:imei].nil? && params[:imei].length > 0
    erb :index
  end

  protected

  def fetch_imei_info(imei)
    @imei = imei
    scraper = AppleWarranty::Scraper.new
    if scraper.get_data(@imei)
      @is_expired = scraper.warranty_expired?
      @expired_at = scraper.warranty_expired_at
    else
      @errors = scraper.errors
    end
  end
end
