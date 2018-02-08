EVENTBRITE-like
Check l'application correspondante au projet: Eventbrite(the fake).

1. Models, signup, sign-in
1.1. Préparatifs
rails new eventbrite-like
cd eventbrite-like
Ouvrir le dossier dans sublime-text. Supprimer le contenu du gemfile pour le remplacer par ce contenu: Gemfile de Felix. (pour le correcteur: bundle install --without production puis db:migrate). 


1.2. Les models
On initialize notre application avec 2 models users et event. 
On leur donnes les attributs suivants grâce à la console:
rails generate model users name:string 
et
rails generate model event description:text date:datetime place:string 

Etant donné qu'un User peut créer plusieurs évènements, on va créer sa relation:
Donc dans le model user, ajouter: has_many :created_events, class_name: "Event".
REMARQUE: le class_name permet de relier ce model user avec la class Event du model event. 

De fait, le model event, qui va accueillir ce nouvel event, doit se le faire spécifier: 
belongs_to :creator, class_name: "User", foreign_key: "user_id" 

En toute logique, un évènement va avoir des attendees (à moins que ce soit un évènement de merde, et encore, on part du principe qu l'organisateur croit en son projet).
Dans le model event, il va donc falloir présicer que l'evenement appartient à un utilisateur et aussi à plusieurs utilisateurs (attendees), on sort donc le bon vieux has_and_belongs_to des familles, de la sorte:
has_and_belongs_to_many :attendees, class_name: "User" 

De l'autre côté, l'utilisateur a des attended_events, a savoir qu'il VA à l'évènement. Si on regarde la liste des invités, l'utilisateur y sera. On peut donc dire qu'il appartient à cet évènement en quelques sortes...:
Ok on va dire tout ça à RoR:
has_and_belongs_to_many :attended_events, class_name: "Event" 

On va créer nos migrations afin de pouvoir ajouter l'utilisateur à la table des events:
rails generate migration AddUserToEvents
Dans cette migration on va demander à ajouter une référence(:user, foreign_key: true) à la table :events. 
add_reference :events, :user, foreign_key: true 
Ensuite on va demander à Rails de créer une table dans notre base de donnée, à base de 2 tables existantes que sont events et users. rails generate migration CreateJoinTableEventsUsers 


1.3. Controller-Users
1.3.1 MethodMan
Là on se dit "Pourquoi ne pas créer un controller qui appellerait ces models fraîchement créés?". Et bien oui dis donc, qu'attendons nous ? 
rails g controller users Dans ce controller on va faire un petit CRUD dont on a le secret. Alors on va ajouter dedans:(bon, ce CRUD on l'a déjà fait il y a 2 jours, alors un copié/coller fera amplement l'affaire)

           def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Votre profil a bien été créé !"
      redirect_to @user
    else render 'new'
    end
  end

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user
    else render 'edit'
    end
  end
1.3.2 La Routine
Ouvrons notre config > routes.rb 
D'accord maintenant on peut se poser la question, quelle va être notre page principale, quand le visiteur arrive sur le site pour la premiere fois? Disons: root 'users#index'pour qu'on tombe sur la methode index de notre controlleur users (soit:@users = User.all). On met aussi le resources :users, je sais pas trop pourquoi par contre, faut demander à Félix. 

La juste après ça, j'ai eu la flemme de continuer :) 
