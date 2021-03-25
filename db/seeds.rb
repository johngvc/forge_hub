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
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1614881462/gd2mevto31otse2d7nnsuf0xgzsf.jpg'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1614881462/gd2mevto31otse2d7nnsuf0xgzsf.jpg'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1616685608/hc4ke1pwz380mztkbd81w74o1shs.jpg'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1615573749/i3kv9yzw9cr1npfib0n59q98g1na.jpg')
            ] 
project_imgs = [
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1613760066/sample.jpg'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1614966621/72hvsiciieeo9p8ppgvs41cv9p59.jpg'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1614977583/u2zl71i7fxqrqdhhuil9q9f02pk0.png'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1614961721/9lncdodrctft0ng0oeznj01i2tnq.jpg'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1614970462/x3fzvoapgmixhyrwgpgoks5kyjg2.jpg'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1614972266/bg01qjijnq988tzudbwtlqqxh4ou.jpg'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1615574414/vy6yig9x46geepzvfilenfa245ln.jpg'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1615574609/jghimvzkhs8hgvam3s4nssmcjdr6.png'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1615574225/4zg6ruucqdpjh91d4cifdjamj4zw.jpg'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1615572915/c59e7jox3x8pljiq4ybzcjln8eph.png'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1615573260/nn9vclc7etxz7bwr75ykp0umg2xe.png'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1615572411/8e3kelrq24o230it8vdi3fqq0rdn.jpg')
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
user_imgs.length.times do
    newUser = User.new({
                        name: Faker::Games::SuperMario.unique.character.truncate(20),
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
project_imgs.length.times do
    newProject = Project.new({
                        name: Faker::Games::Minecraft.unique.achievement.truncate(20),
                        user: User.all.sample,
                        description: Faker::Lorem.paragraph_by_chars(number: 120),
                        linkedin_url: Faker::Internet.email(domain: 'linkedin'),
                        github_url: Faker::Internet.email(domain: 'github'),
                        trello_url: Faker::Internet.email(domain: 'trello'),
                        is_suspended: [true, false].sample,
                        status_project:  ['idea', 'design', 'pre-production', 'development', 'growth'].sample
                        })
    newProject.photo.attach(io: project_imgs[iterator], filename: "#{alphabet[iterator]}#{alphabet[iterator]}.png", content_type: 'image/jpg')
    if newProject.save
        puts "Projeto id: #{Project.last.id} criado com o nome: #{Project.last.name}"
    else
        puts "Falha no salvamento do projeto"
    end
    
    puts "-"*5
    puts "Instanciando o participantes do projeto :#{Project.last.name}"
    nowTime = DateTime.now
    # Instanciando o founder do projeto
    newParticipant = Participant.new({
                                    user_id: Project.last.user_id,
                                    project_id: Project.last.id,
                                    is_founder: true,
                                    invited_at: nowTime,
                                    accepted_at: nowTime,
                                    status: "founder"
                                    })
    newParticipant.save

    # Instanciando membros do projeto
    user_iterator = 0
    users_excluding_founder = User.all.select do |user|
      # Exclui o usuário founder do projeto
      user unless user.id == Project.last.participants[0].user_id
    end

    # Randomiza a quantidade de participantes do projeto (sempre excluindo o founder)
    rand(0..(user_imgs.length - 1)).times do
      newParticipant = Participant.new({
                                      user_id: users_excluding_founder[user_iterator].id,
                                      project_id: Project.last.id,
                                      is_founder: false,
                                      invited_at: nowTime,
                                      accepted_at: nowTime,
                                      status: ["cofounder", "member", "invitee"].sample
                                      })
      newParticipant.save
      user_iterator += 1
    end

    puts "#"*50
    puts "Projeto: #{Project.last.name}"
    puts "Founder: #{User.find(Project.last.user_id).name}"
    puts "-"*10 + "Membros" + "-"*10
    Project.last.participants.each_with_index do |participant, index|
    puts "#{index + 1}: #{User.find(participant.user_id).name} | role: #{participant.status}"
    end
    
    iterator = iterator + 1
    puts "#"*50
end
puts "Finalizada sequencia de seed"
