function PacketAttribute(attributeName, attributeType, attributeMult) constructor {

	name = attributeName;
	type = attributeType;
	boolean = false;
	multiplier = attributeMult;

}


function PacketAttributeListBuilder() constructor {

    data = [];

	static add = function(name, type, multiplier = 1) {
        array_push(self.data, new PacketAttribute(name, type, multiplier));
        return self;
    }

    static asBoolean = function() {
        self.data[array_length(self.data) - 1].boolean = true;
        return self;
    }

    static build = function() {
        return self.data;
    }

}