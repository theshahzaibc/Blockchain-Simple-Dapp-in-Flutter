// ignore_for_file: deprecated_member_use
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class ContractLinking extends ChangeNotifier {
  final String _rpcUrl = "http://127.0.0.1:7545";
  final String _wsUrl = "ws://127.0.0.1:7545/";
  final String _privateKey =
      "714eba6b3464f82c9eb90b77c7037ccf8cc9d6f04c274d360464a98c0edec1fe";

  late Web3Client _client;
  bool isLoading = true;

  late String _abiCode;
  late EthereumAddress _contractAddress;

  late Credentials _credentials;

  late DeployedContract _contract;
  late ContractFunction _setDrug;
  late ContractFunction _getExpiryDate;

  late String expiryDate;

  ContractLinking() {
    initialSetup();
  }

  initialSetup() async {
    // establish a connection to the ethereum rpc node. The socketConnector
    // property allows more efficient event streams over websocket instead of
    // http-polls. However, the socketConnector property is experimental.
    _client = Web3Client(_rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(_wsUrl).cast<String>();
    });

    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    // Reading the contract abi
    String abiStringFile =
        await rootBundle.loadString("src/artifacts/Drug.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abiCode = jsonEncode(jsonAbi["abi"]);

    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);
  }

  Future<void> getCredentials() async {
    _credentials = await _client.credentialsFromPrivateKey(_privateKey);
  }

  Future<void> getDeployedContract() async {
    // Telling Web3dart where our contract is declared.
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "Drug"), _contractAddress);

    // Extracting the functions, declared in contract.
    _getExpiryDate = _contract.function("expireDate");
    _setDrug = _contract.function("setDrug");
    getExpiry();
  }

  getExpiry() async {
    print("get");
    // Getting the current name declared in the smart contract.
    var currentName = await _client
        .call(contract: _contract, function: _getExpiryDate, params: []);
    expiryDate = currentName[0];
    isLoading = false;
    notifyListeners();
  }

  setDrug(var data) async {
    var _list = data.values.toList();
    print(_list);
    // Setting the name to nameToSet(name defined by user)
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _setDrug,
            parameters: [
              _list[0],
              _list[1],
              _list[2],
              _list[3],
              _list[4],
              _list[5],
              _list[6]
            ]));
    getExpiry();
  }
}
