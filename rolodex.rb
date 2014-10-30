# Create a new class Object to
class Rolodex
  # to all only the reading of the array
  attr_reader :contacts


  # Global Class Variable for the index
  @@index = 1000

  # initialize a new contact array
  def initialize
    @contacts = []
  end

  # this method adds a new unique identifier, increment the index, and add the contact ID into @contacts array
  def add_contact(contact)
    contact.id = @@index
    @@index += 1
    @contacts << contact
  end

  # this method is for finding a contact in the Rolodex.Object
  def find(contact_id)
     @contacts.find{|contact| contact.id == contact_id}
  end

  # this code edits the contact
  def edit_contact(first_name,last_name,email,note)
    @selected_contact.first_name = first_name
    @selected_contact.last_name = last_name
    @selected_contact.email = email
    @selected_contact.note = note
  end

  def display_all
    @contacts.each do |contact|
      puts "Contact ID: #{contact.id},  #{contact.first_name} #{contact.last_name} <#{contact.email}>, NOTE: #{contact.note}"
    end
  end

  def display_attribute(contact_id)
    @contacts.each do |contact|
      if contact.id == contact_id
        return contact
      end
    end
  end

  def delete_contact(id_delete)
    # delete the @contacts.Object if the contact ID is == the id_delete parameter
    @contacts.delete_if{|contact| contact.id == id_delete}
  end
end