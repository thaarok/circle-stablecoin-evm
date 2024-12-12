/**
 * Copyright 2024 Circle Internet Financial, LTD. All rights reserved.
 *
 * SPDX-License-Identifier: Apache-2.0
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

pragma solidity 0.6.12;

import "forge-std/console.sol"; // solhint-disable no-global-import, no-console
import { Script } from "forge-std/Script.sol";
import { DeployImpl } from "./DeployImpl.sol";
import { FiatTokenProxy } from "../../contracts/v1/FiatTokenProxy.sol";
import { FiatTokenV2_2 } from "../../contracts/v2/FiatTokenV2_2.sol";
import { MasterMinter } from "../../contracts/minting/MasterMinter.sol";

/**
 * A utility script to deploy Fiat Token contract implementation only
 */
contract DeployFiatToken is Script, DeployImpl {
    address private immutable THROWAWAY_ADDRESS = address(1);

    uint256 private deployerPrivateKey;

    /**
     * @notice initialize variables from environment
     */
    function setUp() public {
        deployerPrivateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");
    }

    function _deploy() internal returns (FiatTokenV2_2) {
        vm.startBroadcast(deployerPrivateKey);

        // Deploy the latest implementation contract code to the network.
        FiatTokenV2_2 fiatTokenV2_2 = getOrDeployImpl(address(0));

        vm.stopBroadcast();

        return (fiatTokenV2_2);
    }

    /**
     * @notice main function that will be run by forge
     */
    function run() external returns (FiatTokenV2_2) {
        return _deploy();
    }
}
