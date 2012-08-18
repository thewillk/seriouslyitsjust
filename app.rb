require 'sinatra'
require 'haml'

default_instructions = [
  'Shut your laptop lid.',
  'Stand up from your chair.',
  'Go outside the office.',
  'Find a nice cafe near the office.'
]

all_instructions = {
  :coffee => {},
  :'seriously-its-just' => {
    :display => "seriously.. it's just", # optional, defaults to param[:id]
    :instructions => [
      'Put together a stupid list.',
      'Think of a title.',
      'Associate it with a key.',
      'Add it to this app.',
      'Deploy to Heroku.'
    ]
  },
  :lunch => {}
}

get '/' do
  available_instructions = all_instructions.keys
  random_instruction = available_instructions.sample.to_s
  redirect '/' + random_instruction
end

get '/:id' do
  topic = params[:id].to_sym
  if all_instructions[topic] then
    instructions = all_instructions[topic][:instructions] || default_instructions
    display_name = all_instructions[topic][:display] || params[:id]

    page_title = ["Seriously.. it's just ","."].join display_name

    haml :instruct, {:locals => { :page_title => page_title, :instructions => instructions }}
  else
    redirect '/'
  end
end
