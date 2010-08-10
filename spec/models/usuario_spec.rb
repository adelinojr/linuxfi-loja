require File.join(File.dirname(__FILE__),"..","spec_helper")

describe Usuario do

  context "ao autentica a senha usuário" do

    before do
      @usuario = Factory( :usuario, :senha => "123456", :senha_confirmation => "123456")
    end

    it "deve dizer que a senha é correta se ela for '123456' " do
        @usuario.senha_correta?("123456").should be_true
    end

    it "deve dizer que a senha é incorreta se ela for '654321'" do
      @usuario.senha_correta?("654321").should be_false
    end

  end

  context "ao autentica usuário" do

    before do
      @usuario = Factory( :usuario, :email => "cade@gmail.com", :senha => "123456", :senha_confirmation => "123456")
    end

    it "deve trazer o usuario quando os dados estiverem corretos" do
      Usuario.autenticar("cade@gmail.com", "123456").should  == @usuario
    end

    it "deve retornar nil quand os dados estivera incorretos" do
      Usuario.autenticar("cade2@gmail.com", "123456").should be_nil
    end

  end

  context "em chamadas de pedido_atual" do

    before do
      @usuario = Factory(:usuario)
      @pedido  = Factory(:pedido, :usuario_id => @usuario.id)
    end

    it "deve retornar o pedido criado anteriomete" do
      @usuario.pedido_atual.should == @pedido
    end

    it "deve criar um novo pedido se ele não existir no banco" do
      @pedido.destroy
      @usuario.pedido_atual.should_not be_nil
    end

    it "deve garantir que ha apenas um pedido atual depois no banco" do
      @pedido.destroy
      @usuario.pedido_atual
      Pedido.count.should == 1
    end

  end

end