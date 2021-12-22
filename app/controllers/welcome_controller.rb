class WelcomeController < ApplicationController
  def index
    #cookies[:curso] = "Curso de Ruby on Rails - Lucas Rabelo [COOKIE]" 
   # session[:curso] = "Curso de Ruby on Rails - Lucas Rabelo [SESSION]" 
    @meu_nome = params[:nome]
    @curso = params[:curso]
  end
end
