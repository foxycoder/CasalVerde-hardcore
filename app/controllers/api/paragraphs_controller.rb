class Api::ParagraphsController < ApplicationController
skip_before_filter :verify_authenticity_token
before_filter :set_page

  def create
    paragraph = @page.paragraphs.new(paragraph_params)
    # @paragraph.page_id = @page.id

    if paragraph.save
      render status: 200, json: {
        message: "paragraph created",
        page: @page,
        paragraph: paragraph
      }.to_json
    else
      render status: 422, json: {
        message: "paragraph coudn't be created",
        errors: paragraph.errors
      }.to_json
    end
  end

  private

  def set_page
    @page = Page.find(params[:page_id])
  end

  def paragraph_params
    params.require(:paragraph).permit(:heading, :text)
  end
end