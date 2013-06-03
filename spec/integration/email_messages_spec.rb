require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "receiving email" do

  it "present email content" do

    user=users(:bob_smith_user)
    ir=info_requests(:fancy_dog_request)
    pb=public_bodies(:humpadink_public_body)
    raw_email=raw_emails(:folding_raw_email)
    incoming_message = IncomingMessage.new
    incoming_message.raw_email=raw_email


    user.save!
    ir.user=user
    ir.public_body=pb
    ir.save!
    pb.save!
    incoming_message.info_request=ir
    incoming_message.save!

    raw_email.incoming_message=incoming_message
    incoming_message.get_main_body_text_folded.should include("FOLDED")

  end
end

