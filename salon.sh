#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=salon --no-align --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"

echo -e "Welcome to My Salon, how can I help you?"

SERVICES_OFFERS=$($PSQL "Select service_id,name From services");
DISPLAY_SERVICE_OFFER(){
echo "$SERVICES_OFFERS"|while IFS='|' read SERVICE_ID NAME_SERVICE
do
   echo "$SERVICE_ID) $NAME_SERVICE"
done
}

DISPLAY_SERVICE_OFFER

NUMBER_OF_SERVICES=$($PSQL "Select Count(service_id) From services");

read SERVICE_ID_SELECTED
while [[ $SERVICE_ID_SELECTED > $NUMBER_OF_SERVICES ]]
    do
    echo -e "\nI could not find that service. What would you like today?"
    DISPLAY_SERVICE_OFFER
    read SERVICE_ID_SELECTED
    done

SERVICE_NAME=$($PSQL "Select name From services Where service_id=$SERVICE_ID_SELECTED");

echo -e "\nWhat's your phone number?"
read CUSTOMER_PHONE

CUSTOMER_NAME=$($PSQL "Select name From customers Where phone='$CUSTOMER_PHONE'");

if [[ -z $CUSTOMER_NAME ]]
    then 
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    
    INSERT_NEW_CUSTOMER=$($PSQL "Insert Into customers(name,phone) Values ('$CUSTOMER_NAME','$CUSTOMER_PHONE')"); 
    CUSTOMER_ID=$($PSQL "Select customer_id From customers Where name='$CUSTOMER_NAME'");

    echo -e "What time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
    read SERVICE_TIME

    INSERT_NEW_APPOINTMENT=$($PSQL "Insert into appointments(customer_id,service_id,time) Values($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')");
    echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."

    else 
    echo -e "What time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
    read SERVICE_TIME

    CUSTOMER_ID=$($PSQL "Select customer_id From customers Where name='$CUSTOMER_NAME'");

    INSERT_NEW_APPOINTMENT=$($PSQL "Insert into appointments(customer_id,service_id,time) Values($CUSTOMER_ID,$SERVICE_ID_SELECTED,'$SERVICE_TIME')");
    echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
    fi



