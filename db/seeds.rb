# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Post.destroy_all
Section.destroy_all

FactoryBot.create(:post)

parent_post = FactoryBot.create(:post)

2.times { FactoryBot.create(:post, parent: parent_post) }

section = FactoryBot.create(:section, name: Faker::University.suffix, post: parent_post)
FactoryBot.create(:post, parent: parent_post, section: section)

section2 = FactoryBot.create(:section, name: Faker::University.suffix, post: parent_post)
2.times { FactoryBot.create(:post, parent: parent_post, section: section2) }

puts "Path to one of the generated posts: /#{Post.parents.last.slug}"
