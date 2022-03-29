const Drug = artifacts.require("Drug") ;

contract("Drug" , () => {
	it("Drug Testing" , async () => {
	const drug = await Drug.deployed() ;
	await drug.setDrug("PANADOL", "10-03-2022", "10-10-2022", 100, "CHADHARS", "H2O", "MBBS-M");
	const result = await drug.getExpiryDate();
	assert(result === "10-10-2022");
	});
});
