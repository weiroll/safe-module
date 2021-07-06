pragma solidity ^0.8.4;

import "@gnosis.pm/safe-contracts/contracts/GnosisSafe.sol";
import "@weiroll/weiroll/contracts/Executor.sol";

contract WeirollModule {

    string public constant NAME = "Weiroll Module";
    string public constant VERSION = "0.1.0";

    // @TODO WE WANT TO BE ABLE TO CAST BUT GNOSISSAFE ALSO HAS EXECUTOR
    address public executor;

    constructor(address _executor) {
        executor = _executor;
    }

    // @TODO access control
    function executeWeiroll(GnosisSafe safe, bytes32[] calldata commands, bytes[] memory state) public {
        bytes memory data = abi.encodeWithSignature("execute(bytes32[],bytes[])", commands, state);

        require(
            safe.execTransactionFromModule(address(executor), 0, data, Enum.Operation.DelegateCall),
            "Could not execute script"
        );
    }

}
