ActiveAdmin.register Book do
  permit_params :title, :price, :quantity, :publication_year, :description, :material, :image,
                :height, :width, :depth, :category_id, author_ids: []

  index do
    selectable_column
    column :category
    column :image do |book|
      image_tag(book.images.first_or_initialize.image.url(:small_img))
    end
    column :description
    column :authors
    column :price
    actions
  end

  show do
    attributes_table do
      row :id
      row :category
      row :title
      row :image do |book|
        image_tag(book.images.first_or_initialize.image.url(:small_img))
      end
      row :authors
      row :price
      row :description
      row :publication_year
      row :material
      row :width
      row :height
      row :depth
      row :quantity
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :price
      f.input :category_id
      f.input :quantity
      f.input :description
      f.input :material
      f.input :images, as: :file
      f.input :authors, as: :check_boxes, collection: Author.all
    end
    f.actions
  end
end
