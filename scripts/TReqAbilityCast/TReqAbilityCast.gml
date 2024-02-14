function TReqAbilityCast(): NetworkingPacket(NetworkingChannel.TCP, TCPServerRequest.ABILITY_CAST) constructor{

	static attributes = new PacketAttributeListBuilder()
		.add("ability", buffer_u8)
		.add("abilityN", buffer_u8)
		.build();

	ability = 0;
	abilityN = 0;

}