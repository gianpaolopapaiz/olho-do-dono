  # This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# TODO: Write a seed
#require 'faker'
def insert_products(rest)
    produto = Product.new()
    produto.name = 'Pizza Calabresa'
    produto.description = 'Nossa Calabresa é preparada com a tradicional Calabresa Italiana, defumada naturalmente e coberta com cebolas em rodelas.'
    produto.category = 'Food'
    produto.restaurant_id = rest
    produto.price = 72 + rand(1..20)
    photo_path = './app/assets/images/pizza_calabresa.jfif'
    produto.photo.attach(io: File.open(photo_path), filename: 'photo1.jpg', content_type: 'image/jpg')
    produto.save
    puts "Product #{produto.id} - #{produto.name} created"
    produto = Product.new()
    produto.name = 'Pizza Portuguesa'
    produto.description = 'Portuguesa é feita com Presunto Seara cozido no vapor. Essa combinação fica ainda mais saborosa com a cobertura de ovos, cebolas em rodelas e ervilhas frescas.'
    produto.category = 'Food'
    produto.restaurant_id = rest
    produto.price = 72 + rand(1..20)
    photo_path = './app/assets/images/pizza_portuguesa.jfif'
    produto.photo.attach(io: File.open(photo_path), filename: 'photo2.jpg', content_type: 'image/jpg')
    produto.save
    puts "Product #{produto.id} - #{produto.name} created"
    produto = Product.new()
    produto.name = 'Pizza Marguerita'
    produto.description = 'Molho de tomate, muçarela ralada grosso, rodelas de tomate (ou metades de tomate-cereja) e folhas de manjericão.'
    produto.category = 'Food'
    produto.restaurant_id = rest
    produto.price = 56 + rand(1..20)
    photo_path = './app/assets/images/pizza_marguerita.jfif'
    produto.photo.attach(io: File.open(photo_path), filename: 'photo3.jpg', content_type: 'image/jpg')
    produto.save
    puts "Product #{produto.id} - #{produto.name} created"
    produto = Product.new()
    produto.name = 'Pizza Especial'
    produto.description = 'Segredo do pizzaiolo, com muito queijo, rodelas de tomate e folhas de manjericão.'
    produto.category = 'Food'
    produto.restaurant_id = rest
    produto.price = 56 + rand(1..20)
    photo_path = './app/assets/images/pizza_especial.jfif'
    produto.photo.attach(io: File.open(photo_path), filename: 'photo4.jpg', content_type: 'image/jpg')
    produto.save
    puts "Product #{produto.id} - #{produto.name} created"

    produto = Product.new()
    produto.name = 'Cerveja Heineken'
    produto.description = 'Garrafa long-neck, bem GELADA!'
    produto.category = 'Beverage'
    produto.restaurant_id = rest
    produto.price = 8 + rand(1..10)
    photo_path = './app/assets/images/heineken.jfif'
    produto.photo.attach(io: File.open(photo_path), filename: 'photo5.jpg', content_type: 'image/jpg')
    produto.save
    puts "Product #{produto.id} - #{produto.name} created"
    produto = Product.new()
    produto.name = 'Coca-Cola'
    produto.description = 'Em lata 350ml'
    produto.category = 'Beverage'
    produto.restaurant_id = rest
    produto.price = 8 + rand(1..10)
    photo_path = './app/assets/images/coca-cola.jfif'
    produto.photo.attach(io: File.open(photo_path), filename: 'photo6.jpg', content_type: 'image/jpg')
    produto.save
    puts "Product #{produto.id} - #{produto.name} created"
    produto = Product.new()
    produto.name = 'Guaraná'
    produto.description = 'Em lata 350ml'
    produto.category = 'Beverage'
    produto.restaurant_id = rest
    produto.price = 8 + rand(1..10)
    photo_path = './app/assets/images/guarana.jfif'
    produto.photo.attach(io: File.open(photo_path), filename: 'photo7.jpg', content_type: 'image/jpg')
    produto.save
    puts "Product #{produto.id} - #{produto.name} created"
    produto = Product.new()
    produto.name = 'Água SEM gás'
    produto.description = 'Água mineral sem gás, 300ml'
    produto.category = 'Beverage'
    produto.restaurant_id = rest
    produto.price = 8 + rand(1..10)
    photo_path = './app/assets/images/agua.jfif'
    produto.photo.attach(io: File.open(photo_path), filename: 'photo8.jpg', content_type: 'image/jpg')
    produto.save
    puts "Product #{produto.id} - #{produto.name} created"
    produto = Product.new()
    produto.name = 'Sundae'
    produto.description = 'Sundae de chocolate com duas bolas de sorvete'
    produto.category = 'Dessert'
    produto.restaurant_id = rest
    produto.price = 15 + rand(1..10)
    photo_path = './app/assets/images/sundae.jfif'
    produto.photo.attach(io: File.open(photo_path), filename: 'photo9.jpg', content_type: 'image/jpg')
    produto.save
    puts "Product #{produto.id} - #{produto.name} created"
    produto = Product.new()
    produto.name = 'Brigadeiro'
    produto.description = 'Seis deliciosos brigadeiros, preparados com chocolate ao-leite.'
    produto.category = 'Dessert'
    produto.restaurant_id = rest
    produto.price = 15 + rand(1..10)
    photo_path = './app/assets/images/brigadeiro.jfif'
    produto.photo.attach(io: File.open(photo_path), filename: 'photo10.jpg', content_type: 'image/jpg')
    produto.save
    puts "Product #{produto.id} - #{produto.name} created"
end

def insert_terminal(rest)
  terminal1 = Terminal.new()
  terminal1.name = 'Credit - Visa - Moderninha'
  terminal1.flag = 'Visa'
  terminal1.payment_type = 'Credit'
  terminal1.payment_day = 20
  terminal1.closing_day = 15
  terminal1.fee_percentage = 1
  terminal1.restaurant = rest
  terminal1.save
  puts "terminal 1 created"
  terminal2 = Terminal.new()
  terminal2.name = 'Credit - Mastercard - Moderninha'
  terminal2.flag = 'Mastercard'
  terminal2.payment_type = 'Credit'
  terminal2.payment_day = 25
  terminal2.closing_day = 20
  terminal2.fee_percentage = 1.5
  terminal2.restaurant = rest
  terminal2.save
  puts "terminal 2 created"
  terminal3 = Terminal.new()
  terminal3.name = 'Debit - Maestro - Stone'
  terminal3.flag = 'Maestro'
  terminal3.payment_type = 'Debit'
  terminal3.payment_day = 30
  terminal3.closing_day = 25
  terminal3.fee_percentage = 2
  terminal3.restaurant = rest
  terminal3.save
  puts "terminal 3 created"
end

def insert_tables(rest)
	t1 = Time.parse("2021-01-02 12:00:00")
	t2 = Time.parse("2021-06-10 23:00:00")
	#table
	30.times do
		8.times do |index|
			puts "Adding table to space #{index + 1}"
			table = Table.new()
			table.restaurant = rest
			table.number = index + 1
			table.terminal = rest.terminals.sample
			table.rating = rand(1..5)
			table.comment = Faker::Restaurant.review 
			table.status = 'closed'
			table.save
			table.payment_due_date = rand(t1..t2)
      table.updated_at = rand(t1..t2)
      table.payment_fee_amount = table.terminal.fee_percentage 
			table.save
			#order_items
			5.times do
				puts 'Adding items to table'
				order_item = OrderItem.new()
				order_item.table = table
				order_item.product = rest.products.sample
				order_item.product_quantity = rand(1..3)
				order_item.status = 'paid'
        order_item.updated_at = table.updated_at
				order_item.save
			end
		end
	end
end

def insert_expenses(rest)
	t1 = Time.parse("2021-01-02 12:00:00")
	t2 = Time.parse("2021-12-20 23:00:00")
	50.times do |index|
		puts "Adding expense #{index + 1} for restaurant #{rest.name}"
		exp = Expense.new
		exp.restaurant = rest
		exp.due_date = rand(t1..t2)
		exp.category = ['Payroll', 'Rent&Utilities', 'Office', 'Inputs'].sample
		exp.description = "product for #{exp.category}"
		exp.amount = rand(500...5000)
		exp.save
	end
end

puts "Cleaning database..."
OrderItem.destroy_all
Expense.destroy_all
Product.destroy_all
Table.destroy_all
Restaurant.destroy_all
Terminal.destroy_all
User.destroy_all

puts 'Creating fake users...'

usuario = User.new()
usuario.email = 'joaquim@dono.com.br'
usuario.password = '123456'
usuario.password_confirmation = '123456'
usuario.first_name = 'Joaquim'
usuario.last_name = 'Oliveira'
usuario.phone = '(11) 99933-8833'
photo_path1 = './app/assets/images/dono1.jfif'
usuario.photo.attach(io: File.open(photo_path1), filename: 'perfil1.png', content_type: 'image/jpg')
usuario.save
puts "User ID: #{usuario.id}, Email: #{usuario.email}  created"

restaurante = Restaurant.new()
restaurante.name = '1900 - Moema'
restaurante.address = 'Alameda dos Nhambiquaras, 573 - Moema, São Paulo - SP, 04090-011'
restaurante.phone = '(11) 5575-1900'
restaurante.nbr_of_tables = 15
restaurante.user_id = usuario.id
photo_path3 = './app/assets/images/1900.jfif'
restaurante.photo.attach(io: File.open(photo_path3), filename: 'photo3.png', content_type: 'image/jpg')
restaurante.save
puts "Restaurant #{restaurante.id} - #{restaurante.name} created"
insert_products(restaurante.id)
insert_terminal(restaurante)
insert_tables(restaurante)
insert_expenses(restaurante)

restaurante = Restaurant.new()
restaurante.name = '1900 - Morumbi'
restaurante.address = 'R. Dr. Fonseca Brasil, 282 - Morumbi, São Paulo - SP, 05716-060'
restaurante.phone = '(11) 5575-1900'
restaurante.nbr_of_tables = 12
restaurante.user_id = usuario.id
photo_path3 = './app/assets/images/1900.jfif'
restaurante.photo.attach(io: File.open(photo_path3), filename: 'photo3.png', content_type: 'image/jpg')
restaurante.save
puts "Restaurant #{restaurante.id} - #{restaurante.name} created"
# insert_products(restaurante.id)

restaurante = Restaurant.new()
restaurante.name = '1900 - Vila Mariana'
restaurante.address = 'R. Estado de Israel, 240 - Vila Mariana, São Paulo - SP, 04022-000'
restaurante.phone = '(11) 5575-1900'
restaurante.nbr_of_tables = 20
restaurante.user_id = usuario.id
photo_path3 = './app/assets/images/1900.jfif'
restaurante.photo.attach(io: File.open(photo_path3), filename: 'photo3.png', content_type: 'image/jpg')
restaurante.save
puts "Restaurant #{restaurante.id} - #{restaurante.name} created"
# insert_products(restaurante.id)

# usuario = User.new()
# usuario.email = 'manoel@dono.com.br'
# usuario.password = '123456'
# usuario.password_confirmation = '123456'
# usuario.first_name = 'Manoel'
# usuario.last_name = 'Silva'
# usuario.phone = '(11) 99933-8833'
# photo_path2 = './app/assets/images/dono2.jfif'
# usuario.photo.attach(io: File.open(photo_path2), filename: 'perfil1.png', content_type: 'image/jpg')
# usuario.save
# puts "User ID: #{usuario.id}, Email: #{usuario.email}  created"

# restaurante = Restaurant.new()
# restaurante.name = 'Super Pizza'
# restaurante.address = 'Av. Aratãs, 794 - Indianópolis, São Paulo - SP, 04081-004'
# restaurante.phone = '(11) 5096-0176'
# restaurante.nbr_of_tables = 18
# restaurante.user_id = usuario.id
# photo_path3 = './app/assets/images/pizzaria2.jfif'
# restaurante.photo.attach(io: File.open(photo_path3), filename: 'photo11.jpg', content_type: 'image/jpg')
# restaurante.save
# puts "Restaurant #{restaurante.id} - #{restaurante.name} created"
# insert_products(restaurante.id)

# restaurante = Restaurant.new()
# restaurante.name = 'Pizza Prime'
# restaurante.address = 'R. Graúna, 125 - Vila Uberabinha, São Paulo - SP, 04514-000'
# restaurante.phone = '(11) 3884-0305'
# restaurante.nbr_of_tables = 12
# restaurante.user_id = usuario.id
# photo_path3 = './app/assets/images/pizzaria2.jfif'
# restaurante.photo.attach(io: File.open(photo_path3), filename: 'photo12.jpg', content_type: 'image/jpg')
# restaurante.save
# puts "Restaurant #{restaurante.id} - #{restaurante.name} created"
# insert_products(restaurante.id)

# restaurante = Restaurant.new()
# restaurante.name = 'Veridiana'
# restaurante.address = 'Rua Dona Veridiana, 661 - Higienópolis, São Paulo - SP, 01238-010'
# restaurante.phone = '(11) 3120-5050'
# restaurante.nbr_of_tables = 20
# restaurante.user_id = usuario.id
# photo_path3 = './app/assets/images/pizzaria2.jfif'
# restaurante.photo.attach(io: File.open(photo_path3), filename: 'photo13.jpg', content_type: 'image/jpg')
# restaurante.save
# puts "Restaurant #{restaurante.id} - #{restaurante.name} created"
# insert_products(restaurante.id)
# puts 'Finished!'


#6.times do
#  usuario = User.new(username: Faker::IDNumber, email: Faker::Internet.email)
#  usuario.save
#  10.times do
#    post = Post.new(title: Faker::Movie.title,
#                    url: "http://www.#{Faker::Movie.title[/a......./]}.com",
#                    votes: 0,
#                    user_id: usuario[:id])
#    post.save
#  end
#end

#Flat.create!(
#  name: 'Flat confortavel em Moema',
#  address: 'Av. Ibirapuera, 2402 - 14o andar',
#  description: 'Ideal para executivos(as), possui serviço de lavanderia e limpeza de quarto',
#  price_per_night: 150,
#  number_of_guests: 4
#)
#date range

