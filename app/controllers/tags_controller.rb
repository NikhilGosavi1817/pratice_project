class TagsController < ApplicationController
    def new
        @tag=Tag.new
    end

    def create
        @tag=Tag.new(tag_params)
        if @tag.save
            redirect_to root_path, notice: "Tag created successfully"
        else
            render :new
        end
    end

    def tag_params
        params.require(:tag).permit(:name)
    end

    def list
        @tag=Tag.all
        if params[:sort].present?
            sort_column=params[:sort]
            sort_direction= params[:direction] || "desc"
            @tag=@tag.order("#{sort_column} #{sort_direction}")
        end
        @tag=@tag.paginate(page: params[:page], per_page: 10)
    end

    def destroy
        @tag=Tag.find(params[:id])
        @tag.destroy
        redirect_to tag_list_path, notice: "Tag deleted successfully"
    end
end
