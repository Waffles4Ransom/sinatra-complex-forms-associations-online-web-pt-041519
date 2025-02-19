class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(params[:pet])
    @pet.update(owner_id: params[:owner_id]) if params[:owner_id]
    if !params[:owner_name].empty?
      @pet.owner = Owner.create(name: params[:owner_name])
      @pet.save
    end
    # binding.pry
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @pet.name = params[:pet][:name]
    @pet.owner_id = params[:owner_id] if params[:owner_id]
    if !params[:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:owner][:name])
    end 
    @pet.save
    
    redirect to "pets/#{@pet.id}"
  end
end