ActiveAdmin.register Province do
  menu label: "Taxes"
  permit_params :tax_rate
  actions :all, except: [:new, :create, :destroy]

  index do
    column :name
    column :province_code
    column :tax_rate
    column :tax_code
    actions
  end

  form do |f|
    f.semantic_errors
    panel resource.name do
      f.inputs :tax_rate
    end
    f.actions
  end

end
