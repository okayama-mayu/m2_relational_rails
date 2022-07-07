# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Item.destroy_all
Section.destroy_all 

phillys = Section.create!(name: 'Phillys', vegan_options: false, labor_intensity: 4)
vegan_phillys = Section.create!(name: 'Vegan Phillys', vegan_options: true, labor_intensity: 5)
sides = Section.create!(name: 'Sides', vegan_options: true, labor_intensity: 3)
drinks = Section.create!(name: 'Drinks', vegan_options: true, labor_intensity: 1)
kids = Section.create!(name: 'Kids', vegan_options: true, labor_intensity: 2)

phillys.items.create!(name: 'Steak Philly', need_restock: false, price: 10)

vegan_phillys.items.create!(name: 'Vegan Far East', need_restock: true, price: 15)

sides.items.create!(name: 'Pickle Fries', need_restock: false, price: 6)
sides.items.create!(name: 'Vegan Poutine', need_restock: true, price: 10)