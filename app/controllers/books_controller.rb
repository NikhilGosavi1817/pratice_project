class BooksController < ApplicationController
    def new
        @book=Book.new
    end

    def create
        @book=current_user.books.create(book_params)
        if @book.save
            redirect_to root_path, notice: "Book saved successfully"
        else
            render :new
        end
    end

    def book_params
        params.require(:book).permit(:name, :description, :number_of_copy, tag_ids: [])
    end

    def list
        @book=Book.all

        if current_user.student?
            @book=@book.where.not(status: "archived")
        end

        if params[:tags].present?
            tag_names = params[:tags].split(',').map(&:strip)
            @book=@book.tagged_with(tag_names)
        end

        if params[:filter]=="available"
            @book=@book.where(:status=>"available")
        elsif params[:filter]=="not_available"
            @book=@book.where(:status => "not_available")
        end

        if params[:sort].present?
            sort_column=params[:sort]
            sort_direction= params[:direction] || "desc"
            @book=@book.order("#{sort_column} #{sort_direction}")
        end
        @book=@book.paginate(page: params[:page], per_page: 10)
    end

    def show
        @book=Book.find(params[:id])
    end

    def destroy
        @book=Book.find(params[:id])
        @book.destroy
    end

    def archive
        @book=Book.find(params[:id])
        
        @book.status="archived"
        @book.save
        redirect_to book_path(@book), notice: "Book archived successfully"
    end

    def issue
        @book=Book.find(params[:id])
        if @book.available? && @book.available_copy.positive?
            current_user.issued_books << @book
            if @book.available_copy == @book.number_of_copy
                @book.status="not_available"
                @book.save
            end
            redirect_to book_path(@book) ,notice:"Issued Successfully!"
        end
    end

    def like
        @book=Book.find(params[:id])
        @book.likes ||= 0
        @book.likes+=1
        @book.save
        redirect_to book_path(@book) ,notice:"Book liked"
    end

    def issued_list
        @book=current_user.issued_books
        if params[:sort].present?
            sort_column=params[:sort]
            sort_direction= params[:direction] || "desc"
            @book=@book.order("#{sort_column} #{sort_direction}")
        end
        @book=@book.paginate(page: params[:page], per_page: 10)
    end

    def return
        @book=Book.find(params[:id])
        @book_user = current_user.book_users.find_by(book_id: @book.id)
        @book_user.destroy
        redirect_to book_path(@book) ,notice:"Book returned"
    end

    def preview
        @book=Book.find(params[:id])
        pdf = Prawn::Document.new
        pdf.text 'Ruby on Rails', style: :bold, align: :center, size: 50, color: 'FF0000'
        pdf.move_down 5
        user=User.find(@book.user_id)
        pdf.text "written by: #{user.first_name} #{user.last_name}", align: :center
        pdf.move_down 30
        pdf.text 'Description:', size: 30
        pdf.text " This book is about the #{@book.description}", size: 20
        pdf.move_down 20
        pdf.text "Likes: #{@book.likes}", size: 20
        send_data(pdf.render,
            filename: 'book.pdf',
            type: 'application/pdf', 
            disposition: 'inline')
    end

end
