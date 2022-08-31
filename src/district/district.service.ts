import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma.service';
import { District, Prisma } from '@prisma/client';

@Injectable()
export class DistrictService {
  constructor(private prisma: PrismaService) {}

  async districts(params: {
    skip?: number;
    take?: number;
    cursor?: Prisma.DistrictWhereUniqueInput;
    where?: Prisma.DistrictWhereInput;
    orderBy?: Prisma.DistrictOrderByWithRelationInput;
  }): Promise<District[]> {
    const { skip, take, cursor, where, orderBy } = params;
    return this.prisma.district.findMany({
      skip,
      take,
      cursor,
      where,
      orderBy,
    });
  }

  async createDistrict(data: Prisma.DistrictCreateInput): Promise<District> {
    return this.prisma.district.create({
      data,
    });
  }
}
