// SPDX-License-Identifier: LGPL-3.0-only
pragma solidity >=0.8.17;

import "../common/Types.sol";

/// @dev Allocation represents a single allocation for an IBC fungible token transfer.
struct Allocation {
    string sourcePort;
    string sourceChannel;
    Coin[] spendLimit;
    string[] allowList;
}
/// @author Evmos Team
/// @title Authorization Interface
/// @dev The interface through which solidity contracts will interact with smart contract approvals.
interface IICS20Authorization {

    /// @dev Emitted when an ICS-20 transfer authorization is granted.
    /// @param grantee The address of the grantee.
    /// @param granter The address of the granter.
    /// @param allocations the Allocations authorized with this grant
    event IBCTransferAuthorization(
        address indexed grantee,
        address indexed granter,
        Allocation[] allocations
    );

    /// @dev This event is emitted when an granter revokes a grantee's allowance.
    /// @param grantee The address of the grantee.
    /// @param granter The address of the granter.
    event RevokeIBCTransferAuthorization(
        address indexed grantee,
        address indexed granter
    );

    /// @dev Approves IBC transfer with a specific amount of tokens.
    /// @param grantee The address for which the transfer authorization is granted.
    /// @param allocations the allocations for the authorization.
    function approve(
        address grantee,
        Allocation[] calldata allocations
    ) external returns (bool approved);

    /// @dev Revokes IBC transfer authorization for a specific grantee.
    /// @param grantee The address for which the transfer authorization will be revoked.
    function revoke(address grantee) external returns (bool revoked);


    /// @dev Increase the allowance of a given grantee by a specific amount of tokens for IBC transfer methods.
    /// @param grantee The address of the contract that is allowed to spend the granter's tokens.
    /// @param sourcePort the port on which the packet will be sent
    /// @param sourceChannel the channel by which the packet will be sent
    /// @param denom the denomination of the Coin to be transferred to the receiver
    /// @param amount The amount of tokens to be spent.
    /// @return approved is true if the operation ran successfully
    function increaseAllowance(
        address grantee,
        string calldata sourcePort,
        string calldata sourceChannel,
        string calldata denom,
        uint256 amount
    ) external returns (bool approved);


    /// @dev Decreases the allowance of a given grantee by a specific amount of tokens for for IBC transfer methods.
    /// @param grantee The address of the contract that is allowed to spend the granter's tokens.
    /// @param sourcePort the port on which the packet will be sent
    /// @param sourceChannel the channel by which the packet will be sent
    /// @param denom the denomination of the Coin to be transferred to the receiver
    /// @param amount The amount of tokens to be spent.
    /// @return approved is true if the operation ran successfully
    function decreaseAllowance(
        address grantee,
        string calldata sourcePort,
        string calldata sourceChannel,
        string calldata denom,
        uint256 amount
    ) external returns (bool approved);

    /// @dev Returns the remaining number of tokens that a grantee smart contract
    /// will be allowed to spend on behalf of granter through
    /// IBC transfers. This is an empty by array.
    /// @param grantee The address of the contract that is allowed to spend the granter's tokens.
    /// @param granter The address of the account able to transfer the tokens.
    /// @return allocations The remaining amounts allowed to spend for
    /// corresponding source port and channel.
    function allowance(
        address grantee,
        address granter
    ) external view returns (Allocation[] memory allocations);


}