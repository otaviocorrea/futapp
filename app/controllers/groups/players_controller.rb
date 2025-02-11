class Groups::PlayersController < GroupsControllerBase
  before_action :set_player, only: %i[ show edit update ]
  before_action :set_group, only: %i[ index new create edit update destroy ]

  def index
    @players = @group.players.order(:name).paginate(page: params[:page])
    render 'groups/players/index'
  end

  # GET /groups/1 or /groups/1.json
  def show
    @page_title = "#{@player.group.name} > #{@player.name}"
    render 'groups/players/show'
  end

  # GET /groups/new
  def new
    @player = Player.new
    render 'groups/players/new'
  end

  # GET /groups/1/edit
  def edit
    render 'groups/players/new'
  end

  # POST /groups or /groups.json
  def create
    @player = Player.new(player_params)
    @player.group = @group
    @player.picture = Faker::Avatar.image
    @player.cpf = nil if @player.cpf.blank?

    respond_to do |format|
      if @player.save
        format.html { redirect_to group_players_url(@group, @player), notice: "player was successfully created." }
        format.json { render :show, status: :created, location: @player }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    respond_to do |format|
      if @player.update(player_params)
        format.html { redirect_to group_players_url(@group, @player), notice: "player was successfully updated." }
        format.json { render :show, status: :ok, location: @player }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    @player.destroy!

    respond_to do |format|
      format.html { redirect_to @group, notice: "Player was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  

  private
  def set_player
    @player = Player.find(params[:player_id])
  end

  def player_params
    params.require(:player).permit(:name, :nickname, :cpf, :email, :phone, :instagram, :notes)
  end 
end