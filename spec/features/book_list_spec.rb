require 'rails_helper'

RSpec.feature "BooksController", type: :feature do
    describe 'List of book' do
        let!(:user) {create(:user, role_type: 'librarian')}

        let!(:book) {create(:book)}
        
        def update_profile_fields
            sign_in user
            # visit book_list_path(user)
        end

        scenario "user changes the first_name" do
            update_profile_fields
            expect(page).to have_content("Name")
            expect(page).to have_content("Author Name")
            expect(page).to have_content("Creation Date")
            expect(page).to have_content("Likes")
            expect(page).to have_content("Number of copies")
        end

        # sign_in user
        it "user lesves the first_name blank" do
            update_profile_fields
            # book=Book.create
            # book.save
            # binding.pry
            visit book_path(book)
            expect(page).to have_content("Book Details")
        end

    end
end
