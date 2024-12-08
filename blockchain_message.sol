// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MessageSender {
    struct Message {
        address sender;
        address to;
        string content;
        uint256 timestamp;
    }
    
    mapping(address => Message[]) private messages;
    
    event NewMessage(address indexed from, address indexed to, string content);
    
    function sendMessage(address _to, string memory _content) public {
        require(_to != address(0), "Invalid recipient address");
        require(bytes(_content).length > 0, "Message cannot be empty");
        
        Message memory newMessage = Message({
            sender: msg.sender,
            to: _to,
            content: _content,
            timestamp: block.timestamp
        });
        
        messages[msg.sender].push(newMessage);
        messages[_to].push(newMessage);
        
        emit NewMessage(msg.sender, _to, _content);
    }
    
    function readMyMessages() public view returns (Message[] memory) {
        return messages[msg.sender];
    }
}