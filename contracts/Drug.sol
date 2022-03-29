// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
  
contract Drug {
    string public product_name; 
    string public issueDate;
    string public expireDate;
    int256 public price;
    string public manufacturer;
    string public salt;
    string public docsType;

    constructor() public {
        product_name = "Unknown" ;
        issueDate = "10-03-2022";
        expireDate = "10-10-2022";
        price = 100.0;
        manufacturer = "Chadhar";
        salt = "ALT+2";
        docsType = "MBBS";

    }

    function setDrug(string memory product, string memory iDate, string memory exDate, int256 pr, string memory manf, string memory sal, string memory dType) public {
        product_name = product ;
        issueDate = iDate;
        expireDate = exDate;
        price = pr;
        manufacturer = manf;
        salt = sal;
        docsType = dType;
    }

    function getExpiryDate() public view returns (string memory) {
        return expireDate;
    }

}