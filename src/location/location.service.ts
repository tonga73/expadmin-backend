import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma.service';
import { Location, Prisma } from '@prisma/client';

@Injectable()
export class LocationService {
  constructor(private prisma: PrismaService) {}

  async locations(params: {
    skip?: number;
    take?: number;
    cursor?: Prisma.LocationWhereUniqueInput;
    where?: Prisma.LocationWhereInput;
    orderBy?: Prisma.LocationOrderByWithRelationInput;
  }): Promise<Location[]> {
    const { skip, take, cursor, where, orderBy } = params;
    return this.prisma.location.findMany({
      skip,
      take,
      cursor,
      where,
      orderBy,
    });
  }

  async createLocation(data: Prisma.LocationCreateInput): Promise<Location> {
    return this.prisma.location.create({
      data,
    });
  }
}
