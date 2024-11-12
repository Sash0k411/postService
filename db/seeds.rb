# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create!(
  full_name: "Admin User",
  email: "admin@example.com",
  password: "password",
  password_confirmation: "password",
  role: 1
)

regions = [
  { name: 'Автономная Республика Крым', code: 91 },
  { name: 'Амурская область', code: 28 },
  { name: 'Архангельская область', code: 29 },
  { name: 'Астраханская область', code: 30 },
  { name: 'Белгородская область', code: 31 },
  { name: 'Брянская область', code: 32 },
  { name: 'Владимирская область', code: 33 },
  { name: 'Волгоградская область', code: 34 },
  { name: 'Вологодская область', code: 35 },
  { name: 'Воронежская область', code: 36 },
  { name: 'Еврейская автономная область', code: 79 },
  { name: 'Забайкальский край', code: 75 },
  { name: 'Ивановская область', code: 37 },
  { name: 'Иркутская область', code: 38 },
  { name: 'Кабардино-Балкарская Республика', code: 7 },
  { name: 'Калининградская область', code: 39 }
]

regions.each do |region|
  Region.create!(name: region[:name], code: region[:code])
end
