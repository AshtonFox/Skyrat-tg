/obj/item/circuitboard/machine/mining_equipment_vendor/interdyne
	name = "Interdyne Mining Equipment Vendor (Machine Board)"
	build_path = /obj/machinery/mineral/equipment_vendor/interdyne

/**
 * Special DS-2/Interdyne mining vendor so that accesses provided are correct
 */
/obj/machinery/mineral/equipment_vendor/interdyne
	name = "Interdyne mining equipment vendor"
	circuit = /obj/item/circuitboard/machine/mining_equipment_vendor/interdyne

/obj/machinery/mineral/equipment_vendor/interdyne/Initialize(mapload)
	desc += "\nOptimized for Interdyne use.."

	// Remove nanotrasen minebot
	for(var/datum/data/mining_equipment/prize in prize_list)
		if(prize.equipment_path == /mob/living/simple_animal/hostile/mining_drone)
			prize_list -= prize
			break

	// Add interdyne-accessed minebot
	prize_list += list(
		new /datum/data/mining_equipment("Interdyne Minebot", /mob/living/simple_animal/hostile/mining_drone/interdyne, 800),
	)

	return ..()

/// There's no sane way to edit what's redeemed by the voucher, as it's also generated by this proc.
/// BUT, we can replace the minebot when it's spawned.
/obj/machinery/mineral/equipment_vendor/interdyne/redeem_voucher(obj/item/mining_voucher/voucher, mob/redeemer)
	. = ..()
	for(var/mob/living/simple_animal/hostile/mining_drone/drone in drop_location())
		// There could already be an interdyne drone there
		if(!istype(drone, /mob/living/simple_animal/hostile/mining_drone/interdyne))
			qdel(drone)
			new /mob/living/simple_animal/hostile/mining_drone/interdyne(drop_location())

/mob/living/simple_animal/hostile/mining_drone/interdyne
	name = "\improper Interdyne minebot"
	faction = list("neutral", "Syndicate")
