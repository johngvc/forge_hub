# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'open-uri'



alphabet = ("a".."z").to_a
user_imgs = [
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1614880281/pjw3ww13wcf8t1yf1j4285a0fs48.jpg'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1614806606/ds1vkvrnfi9imq3qzgvw5m3iddn1.jpg'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1614881462/gd2mevto31otse2d7nnsuf0xgzsf.jpg')
            ] 
project_imgs = [
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1613760066/sample.jpg'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1614966621/72hvsiciieeo9p8ppgvs41cv9p59.jpg'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1614977583/u2zl71i7fxqrqdhhuil9q9f02pk0.png'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1614961721/9lncdodrctft0ng0oeznj01i2tnq.jpg'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1614970462/x3fzvoapgmixhyrwgpgoks5kyjg2.jpg'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1614972266/bg01qjijnq988tzudbwtlqqxh4ou.jpg')
            ] 



puts "Iniciando a sequencia de seed"
puts "#"*50
puts "Resetando Database"
Participant.delete_all
Project.delete_all
User.delete_all

puts "#"*50
puts "Instanciando usuários"
iterator = 0
3.times do
    newUser = User.new({
                        name: Faker::Food.unique.fruits.truncate(20),
                        email: "#{alphabet[iterator]}@#{alphabet[iterator]}",
                        password: 123123,
                        description: Faker::ChuckNorris.fact.truncate(80)
                        })
    newUser.photo.attach(io: user_imgs[iterator], filename: "#{alphabet[iterator]}.png", content_type: 'image/jpg')
    if newUser.save
        puts "User id: #{User.last.id} salvo com o nome: #{User.last.name}"
    else
        puts "Falha no salvamento do User"
    end
    iterator = iterator + 1
end
puts "#"*50
puts "Instanciando projetos"
iterator = 0
6.times do
    randomStatus = ['idea', 'design', 'pre-production', 'development', 'growth'].sample
    newProject = Project.new({
                        name: Faker::Games::SuperMario.unique.character.truncate(10),
                        user_id: rand(1..3),
                        description: Faker::Lorem.paragraph_by_chars(number: 120),
                        linkedin_url: Faker::Internet.email(domain: 'linkedin'),
                        github_url: Faker::Internet.email(domain: 'github'),
                        trello_url: Faker::Internet.email(domain: 'trello'),
                        is_suspended: false,
                        status_project:  randomStatus
                        })
    newProject.photo.attach(io: project_imgs[iterator], filename: "#{alphabet[iterator]}#{alphabet[iterator]}.png", content_type: 'image/jpg')
    if newProject.save
        puts "Projeto id: #{Project.last.id} criado com o nome: #{Project.last.name}"
    else
        puts "Falha no salvamento do projeto"
    end
    
    puts "-"*5
    puts "Instanciando o dono do projeto :#{Project.last.name}"
    nowTime = DateTime.now
    newParticipant = Participant.new({
                                    user_id: Project.last.user_id,
                                    project_id: Project.last.id,
                                    is_founder: true,
                                    invited_at: nowTime,
                                    accepted_at: nowTime,
                                    status: "founder"
                                    })
    newParticipant.save
    
    iterator = iterator + 1
    puts "#"*50
end
puts "Finalizada sequencia de seed"
