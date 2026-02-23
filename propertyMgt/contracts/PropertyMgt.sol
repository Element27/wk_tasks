// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.28;

import "./IERC20.sol";

contract PropertyMgt {
    IERC20 public token;

    constructor(address _tokenAddress) {
        token = IERC20(_tokenAddress);
    }

    modifier onlyCreator(uint index) {
        require(
            Properties[index].creator == msg.sender,
            "Only creator can remove property"
        );
        _;
    }

    struct Property {
        string name;
        uint price;
        string location;
        address creator;
        bool isSold;
    }

    event PropertyCreated(
        string name,
        uint price,
        string location,
        address creator
    );
    event PropertyRemoved(uint index);
    event PropertyPurchased(uint index, address buyer);

    Property[] public Properties;

    function createProperty(
        string memory _name,
        uint _price,
        string memory _location
    ) public {
        require(_price > 0, "Price must be greater than 0");

        require(bytes(_name).length > 0, "Name must not be empty");
        require(bytes(_location).length > 0, "Location must not be empty");

        Properties.push(Property(_name, _price, _location, msg.sender, false));
        emit PropertyCreated(_name, _price, _location, msg.sender);
    }

    function getAllProperties() public view returns (Property[] memory) {
        return Properties;
    }

    function removeProperty(uint index) public onlyCreator(index) {
        for (uint8 i; i < Properties.length; i++) {
            if (i == index) {
                Properties[i] = Properties[Properties.length - 1];
                Properties.pop();
            }
        }
        emit PropertyRemoved(index);
    }

    function buyProperty(uint index, uint _amount) public {
        require(index < Properties.length, "Property not found");
        require(Properties[index].isSold == false, "Property is already sold");
        require(Properties[index].price == _amount, "Incorrect amount");

        bool success = token.transferFrom(
            msg.sender,
            Properties[index].creator,
            _amount
        );

        require(success, "Payment failed");

        Properties[index].isSold = true;
        emit PropertyPurchased(index, msg.sender);
    }
}
