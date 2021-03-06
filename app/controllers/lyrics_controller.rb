class LyricsController < ApplicationController

	def new
		@lyric = Lyric.new
	end

	def index
		@lyrics = current_user.lyrics
	end

	def create
		@lyric = Lyric.new(lyrics_params)
		@lyric.user = current_user
		if @lyric.save
			Log.create(description: "#{current_user.name} adicionou uma nova letra: #{@lyric.name}")
			redirect_to lyrics_path, notice: "Letra salva com sucesso!"
		else
			render :new
		end
	end

	def show
		@lyric = Lyric.find(params[:id])
	end

	def edit
		@lyric = Lyric.find(params[:id])
	end

	def update
		@lyric = Lyric.find(params[:id])
		if @lyric.update(lyrics_params)
			Log.create(description: "#{current_user.name} editou uma letra antiga: #{@lyric.name}")
			redirect_to lyrics_path, notice: "Letra editada com sucesso!"
		else
			render :edit
		end
	end

	def destroy
		@lyric = Lyric.find(params[:id])
		Log.create(description: "#{current_user.name} apagou uma letra antiga: #{@lyric.name}")
		@lyric.delete
		redirect_to lyrics_path, notice: "Letra apagada com sucesso!"
	end

	private

	def lyrics_params
		params.require(:lyric).permit(:name, :message)
	end
end
