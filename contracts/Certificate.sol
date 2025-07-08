// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CertificateRegistry {
    // owner (admin) of the contract
    address public admin;

    constructor() {
        admin = msg.sender;
    }

    struct Certificate {
        uint256 id;
        string recipientName;
        string courseName;
        uint256 issuedAt;
        address issuer;
    }

    uint256 public certificateCount = 0;

    mapping(uint256 => Certificate) public certificates;

    event CertificateIssued(
        uint256 indexed id,
        string recipientName,
        string courseName,
        uint256 issuedAt,
        address indexed issuer
    );

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can issue certificates");
        _;
    }

    function issueCertificate(
        string memory _recipientName,
        string memory _courseName
    ) public onlyAdmin {
        certificateCount++;
        certificates[certificateCount] = Certificate(
            certificateCount,
            _recipientName,
            _courseName,
            block.timestamp,
            msg.sender
        );

        emit CertificateIssued(
            certificateCount,
            _recipientName,
            _courseName,
            block.timestamp,
            msg.sender
        );
    }

    function getCertificate(uint256 _id)
        public
        view
        returns (
            string memory recipientName,
            string memory courseName,
            uint256 issuedAt,
            address issuer
        )
    {
        Certificate memory cert = certificates[_id];
        return (
            cert.recipientName,
            cert.courseName,
            cert.issuedAt,
            cert.issuer
        );
    }
}
