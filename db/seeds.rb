# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'open-uri'

# Para adicionar mais usuários e projetos
# basta adicionar uma imagem nova nas arrays "user_imgs" e "project_imgs"

tags_count = 20
project_tags_count = 3
user_specialties_count = 3



specialties = [
  "Code",
  "Art",
  "Sound",
  "Design",
  "Business",
  "Finance",
  "Marketing",
  "Law"
  ]
alphabet = ("a".."z").to_a
user_imgs = [
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1614880281/pjw3ww13wcf8t1yf1j4285a0fs48.jpg'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1614806606/ds1vkvrnfi9imq3qzgvw5m3iddn1.jpg'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1614881462/gd2mevto31otse2d7nnsuf0xgzsf.jpg'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1616630728/7tiwm0aquwl2vkuger1rx1i8g3sa.jpg'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1616685608/hc4ke1pwz380mztkbd81w74o1shs.jpg'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1615471388/p9tumyra1btjbcdrysontteptieo.jpg')
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
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1615571588/3kl66226ztx9xc94u9cf2l7sv6tk.jpg'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1615570767/cpbabsxvgwj1s3dngnrhpciwu5vs.jpg'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1615571255/znew5s4eykfsmc673lfrh1qv5nil.png'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1615570274/lw9sl3hqe39l37vgukq933veknf7.jpg'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1615570093/g3bslpmex2v1dy1fuv1x34n4hth4.png'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1615570187/i1um53mvpnfh55fx0m85nx938abv.jpg'),
    URI.open('https://res.cloudinary.com/johngvc/image/upload/v1615572411/8e3kelrq24o230it8vdi3fqq0rdn.jpg')
            ] 

puts "Iniciando a sequencia de seed"
puts "#"*50
puts "Resetando Database"
Participant.delete_all
ProjectTag.delete_all
Tag.delete_all
UserSpecialty.delete_all
Specialty.delete_all
Project.delete_all
Bootcamp.delete_all
ChatMessage.delete_all
JoinRequest.delete_all
ChatroomParticipant.delete_all
Message.delete_all
User.delete_all


puts "#"*50
puts "Instanciando Specialties"
iterator = 1
specialties.length.times do
  Specialty.create({
                    name: specialties[iterator - 1]
                  })
  puts "#{iterator}. #{Specialty.last.name}" 
  iterator += 1
end

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
  puts "Falha no salvamento do User" unless newUser.save

  # Instanciando Tags do projeto

  # O código sempre irá "tentar" instanciar o número de "user_specialties_count" em specialties randomicas
  # Caso ele instancie uma specialty já cadastrada para o projeto ela nao será guardada no banco de dados
  # Devido a vaidaçao presente no modelo.
  user_specialties_count.times do
    offset = rand(Specialty.count) # Randomiza um número do montante total de records
    rand_specialty = Specialty.offset(offset).first # Acessa o record com o valor randomizado a partir do primeiro record do database (Evita Records deletados)
    UserSpecialty.create({
                        user_id: User.last.id,
                        specialty_id: rand_specialty.id
                        })

                        UserSpecialty.create({
                          user_id: 1,
                          specialty_id: 1
                          })
  end
  puts "#"*23 + '  User created  ' + "#"*23
  puts "Name: #{User.last.name}"
  puts "Id: #{User.last.id}"
  puts "-"*10 + "Specialties" + "-"*10
  User.last.specialties.each_with_index do |specialty, index|
    puts "#{index + 1}: #{specialty.name}"
  end

  iterator = iterator + 1
end
puts "#"*50
puts "Instanciando tags"
iterator = 1
tags_count.times do
  Tag.create({
              name: Faker::IndustrySegments.unique.sector
            })
  puts "#{iterator}. #{Tag.last.name}" 
  iterator += 1
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
                      is_suspended: false,
                      status_project:  ['idea', 'design', 'pre-production', 'development', 'growth'].sample,
                      category: ['Arts', 'Comics & Illustration', 'Design & Tech', 'Film', 'Food & Craft', 'Games', 'Music', 'Publishing'].sample
                      })
  newProject.photo.attach(io: project_imgs[iterator], filename: "#{alphabet[iterator]}#{alphabet[iterator]}.png", content_type: 'image/jpg')
  puts "Falha no salvamento do projeto" unless newProject.save
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

  # Instanciando Tags do projeto

  # O código sempre irá "tentar" instanciar o número em project_tags_count em tags randomicas
  # Caso ele instancie uma tag já cadastrada para o projeto ela nao será guardada no banco de dados
  # Devido a vaidaçao presente no modelo.
  project_tags_count.times do
    offset = rand(Tag.count) # Randomiza um número do montante total de records
    rand_tag = Tag.offset(offset).first # Acessa o record com o valor randomizado a partir do primeiro record do database (Evita Records deletados)
    ProjectTag.create({
                      project_id: Project.last.id,
                      tag_id: rand_tag.id
                      })
  end

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
    user_iterator += 1 # Variável para evitar repetir usuários participantes de um projeto
  end

  # Mostrar detalhes do projeto criado no console
  puts " "
  puts "#"*23 + '  Project Created  ' + "#"*23
  puts "Projeto: #{Project.last.name}"
  puts "Founder: #{User.find(Project.last.user_id).name}"
  puts "-"*10 + "Membros" + "-"*10
  Project.last.participants.each_with_index do |participant, index|
    puts "#{index + 1}: #{User.find(participant.user_id).name} | role: #{participant.status}"
  end
  puts "-"*10 + "Tags" + "-"*10
  Project.last.tags.each_with_index do |tag, index|
    puts "#{index + 1}: #{tag.name}"

  end
  
  iterator = iterator + 1
end
puts "Finalizada sequencia de seed"
