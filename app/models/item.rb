class Item < ApplicationRecord

    has_one_attached :image

    belongs_to :user 
    belongs_to :category 

    validates :name, :price, :description, :category_name, presence: true
    validates :name, length: { minimum: 2 }
    validates :description, length: { maximum: 300 }

    scope :search, -> (term) { Item.where("name LIKE ? OR description LIKE ?", "%" + term + "%", "%" + term + "%") }
    
    #finds category by name if it exists or creates if not in database
    def category_name=(name)
        self.category = Category.find_or_create_by(name: name)
    end
    
    #if self.category is true, returns category.name else nil
    def category_name 
        self.category ? self.category.name : nil
    end

    # def self.search(term)
    #     Item.where("name LIKE ? OR description LIKE ?", "%" + term + "%", "%" + term + "%")
    # end

end
