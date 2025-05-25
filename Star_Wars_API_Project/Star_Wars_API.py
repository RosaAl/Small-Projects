
# To run this programme please ensure you have installed requests and wikipedia via the terminal.
# pip install requests
# pip install wikipedia

# The following imports are required for the API, time and file writing.
# The time module is to add some time loops to make the app more fun to watch.
# The Wikipedia module will be used in the .txt file writing at the end so the user can have some further information when they save the results.
import requests
import time
import wikipedia



# The following function creates a greeting.
# Password is Chosen1
def input_message():
    username = input("What is your name, Young Padawan? ")
    def authenticate_user():
        password = input("Enter your password: ")
        pass_correct = password == "Chosen1"
        if pass_correct:
            return "\nHello there, {}!".format(username), "\nWelcome to the Star Wars mystery character information programme!"
        else:
            print("Access Denied! Please start again.")
            quit()
    return authenticate_user

hello_message = input_message()
print(*hello_message())


# The following while loop will allow the user to choose a character from the API. There are 82 to choose from.
character_number = 100
while character_number >= 82:
    character_number = int(input("To choose a mystery character, please type a number between 1 and 82: "))

# To find character name from the number.
character_url = 'https://swapi.dev/api/people/{}/?format=json'.format(character_number)



character_response = requests.get(character_url)
character = character_response.json()


# If needed, can uncomment the below to ensure the status code is 200.
# print(character_response.status_code)


# Added time module to create the below loading site.
print(f"\nYou have found:")
time.sleep(0.5)
def pause_time():
    for _ in range(3):
        print("Loading...")
        time.sleep(1)

pause_time()
print(f"{character["name"].title()}!")



# Used slicing in the API link string just to get the number, this means that when adding to the below, it is changeable for each character to get to their relevant page.
hworld_number = character["homeworld"][-3:-1]
hworld_url = 'https://swapi.dev/api/planets/{}/?format=json'.format(hworld_number)
hworld_response = requests.get(hworld_url)
homeworld = hworld_response.json()


# If needed, can uncomment the below to check different hworld_numbers and/or ensure the status code is 200.
# print(hworld_number)
# print(hworld_response.status_code)


# When inputting response do not include "". y or n are fine.
find_home = input("\nWould you like to find out the planet this character is from? y/n ")
want_home = find_home == 'y'


# If else statements used to guide the user to complete the programme.
if want_home:
    print(f"{character["name"].title()} is from the planet {homeworld["name"].title()}.\n")
else:
    are_you_sure = input("Are you sure you would like to exit the programme? y/n ")
    if are_you_sure == 'y':
        print("Thank you for finding your character name only, please re-run to learn further information and complete the programme.")
        quit()
    if are_you_sure == 'n':
        print(f"{character["name"].title()} is from the planet {homeworld["name"].title()}.\n")


# Re-use of self-made function.
pause_time()
print("\nCongratulations, you have identified your character and home planet. Please find the character information below:")

character_info = (
    (f"Name: {character["name"].title()}"),
    (f"\nHeight: {character["height"].title()}cm"),
    (f"\nHair Colour: {character["hair_color"].title()}"),
    (f"\nSkin Colour: {character["skin_color"].title()}"),
    (f"\nEye Colour: {character["eye_color"].title()}"),
    (f"\nBirth Year: {character["birth_year"]}"),
    (f"\nGender: {character["gender"].title()}"),
    (f"\nHome Planet: {homeworld["name"].title()}")
    )

print(*character_info)



# Writing results to file.
want_write_file = input("\nWould you like to complete the programme and write your character results to a .txt file? y/n ")
no_file = want_write_file == 'n'

if no_file:
    print("\nThank you for finding the mystery character information, your results have not been written to a file. Have a great day!")
else:
    print("\nPUNCH IT CHEWIE!")
    with open('Character Information.txt', 'w') as text_file:
        text_file.write("\nCharacter Information File")
        text_file.write("\nPlease find below some interesting Star Wars information and your character stats: \n")
        text_file.write(wikipedia.summary("StarWars", sentences = 3) + '\n\n')
        for info in character_info:
            text_file.write(str(info))
        text_file.write("\n\nThank you for completing the Star Wars mystery character information programme!")
    print("\nYour results have been written to a file called 'Character Information'. May the Force be with you.")

# END