import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma.service';
import { District, Prisma } from '@prisma/client';

import { UpdateDistrictDto } from './dto/update-district.dto';
@Injectable()
export class DistrictService {
  constructor(private prisma: PrismaService) {}

  async district(
    districtWhereUniqueInput: Prisma.DistrictWhereUniqueInput,
  ): Promise<District | null> {
    return this.prisma.district.findUnique({
      where: districtWhereUniqueInput,
      include: {
        records: true,
      },
    });
  }

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

  async updateDistrict(
    id: number,
    updateDistrictDto: UpdateDistrictDto,
  ): Promise<District> {
    return this.prisma.district.update({
      data: updateDistrictDto,
      where: { id },
    });
  }

  async deleteDistrict(
    where: Prisma.DistrictWhereUniqueInput,
  ): Promise<District> {
    return this.prisma.district.delete({
      where,
    });
  }
}
