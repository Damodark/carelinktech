from django.shortcuts import render, redirect
from .forms import ContactForm
from django.core.mail import send_mail
from django.contrib import messages
from django.conf import settings

def contact_view(request):
    if request.method == 'POST':
        form = ContactForm(request.POST)
        if form.is_valid():
            # Save the message to the database
            form.save()

            # Send confirmation email
            name = form.cleaned_data['name']
            email = form.cleaned_data['email']
            subject = form.cleaned_data['subject']
            message = form.cleaned_data['message']

            full_message = f"Message from {name} ({email}):\n\n{message}"

            try:
                send_mail(
                    subject,
                    full_message,
                    settings.EMAIL_HOST_USER,
                    [settings.EMAIL_TO],  # You receive this email
                    fail_silently=False,
                )
                messages.success(request, "Your message has been sent successfully!")
            except Exception as e:
                messages.warning(request, "We couldn't send an email, but your message was saved.")
            
            return redirect('contact')
    else:
        form = ContactForm()

    return render(request, 'contact.html', {'form': form})