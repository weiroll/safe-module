pragma solidity ^0.8.4;

import "@gnosis.pm/safe-contracts/contracts/GnosisSafe.sol";
import "@weiroll/weiroll/contracts/Executor.sol";

contract WeirollModule {

    string public constant NAME = "Weiroll Module";
    string public constant VERSION = "0.1.0";

    // @TODO WE WANT TO BE ABLE TO CAST BUT GNOSISSAFE ALSO HAS EXECUTOR
    /// Weiroll VM
    address public vm;

    // Safe -> Executor -> Script Hash -> Authorized
    mapping(address => mapping(address => mapping (bytes32 => bool))) executors;

    constructor(address _vm) {
        vm = _vm;
    }

    // @TODO access control
    // @TODO Do signature checks?
    function executeWeiroll(GnosisSafe safe, bytes32[] calldata commands, bytes[] memory state) public {
//        require(executors[address(safe)][msg.sender], "not authorized to execute");

        // @TODO CHECK IF sender can execute the command

        bytes memory data = abi.encodeWithSignature("execute(bytes32[],bytes[])", commands, state);

        require(
            safe.execTransactionFromModule(vm, 0, data, Enum.Operation.DelegateCall),
            "could not execute script"
        );
    }

}
