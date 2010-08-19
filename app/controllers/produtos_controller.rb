class ProdutosController < ApplicationController

  def index
    @titulo   = 'Listagem de Produtos'
    @produtos = if params[:q].blank?
      Produto.all
    else
=begin
      Produto.all( :conditions => ["nome LIKE ? OR descricao LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%"],
                  :order => "preco DESC")
=end
      resultado = Produto.solr_search do |s|
        s.keywords params[:q]
        s.with(:preco)
      end
      resultado.results
    end

    respond_to do |format|
      format.html
      format.xml do
        render :xml => @produtos
      end
    end
  end

  def show
    @produto = Produto.find( params[:id] )
  end
end
